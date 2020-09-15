//===-- lldb-private-interfaces.h -------------------------------*- C++ -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//

#ifndef LLDB_LLDB_PRIVATE_INTERFACES_H
#define LLDB_LLDB_PRIVATE_INTERFACES_H

#if defined(__cplusplus)

#include "lldb/lldb-enumerations.h"
#include "lldb/lldb-forward.h"
#include "lldb/lldb-private-enumerations.h"
#include "lldb/lldb-types.h"
#include <memory>
#include <set>

namespace lldb_private {
typedef lldb::ABISP (*ABICreateInstance)(lldb::ProcessSP process_sp,
                                         const ArchSpec &arch);
typedef std::unique_ptr<Architecture> (*ArchitectureCreateInstance)(
    const ArchSpec &arch);
typedef Disassembler *(*DisassemblerCreateInstance)(const ArchSpec &arch,
                                                    const char *flavor);
typedef DynamicLoader *(*DynamicLoaderCreateInstance)(Process *process,
                                                      bool force);
typedef lldb::JITLoaderSP (*JITLoaderCreateInstance)(Process *process,
                                                     bool force);
typedef ObjectContainer *(*ObjectContainerCreateInstance)(
    const lldb::ModuleSP &module_sp, lldb::DataBufferSP &data_sp,
    lldb::offset_t data_offset, const FileSpec *file, lldb::offset_t offset,
    lldb::offset_t length);
typedef size_t (*ObjectFileGetModuleSpecifications)(
    const FileSpec &file, lldb::DataBufferSP &data_sp,
    lldb::offset_t data_offset, lldb::offset_t file_offset,
    lldb::offset_t length, ModuleSpecList &module_specs);
typedef ObjectFile *(*ObjectFileCreateInstance)(const lldb::ModuleSP &module_sp,
                                                lldb::DataBufferSP &data_sp,
                                                lldb::offset_t data_offset,
                                                const FileSpec *file,
                                                lldb::offset_t file_offset,
                                                lldb::offset_t length);
typedef ObjectFile *(*ObjectFileCreateMemoryInstance)(
    const lldb::ModuleSP &module_sp, lldb::DataBufferSP &data_sp,
    const lldb::ProcessSP &process_sp, lldb::addr_t offset);
typedef bool (*ObjectFileSaveCore)(const lldb::ProcessSP &process_sp,
                                   const FileSpec &outfile, Status &error);
typedef EmulateInstruction *(*EmulateInstructionCreateInstance)(
    const ArchSpec &arch, InstructionType inst_type);
typedef OperatingSystem *(*OperatingSystemCreateInstance)(Process *process,
                                                          bool force);
typedef Language *(*LanguageCreateInstance)(lldb::LanguageType language);
typedef LanguageRuntime *(*LanguageRuntimeCreateInstance)(
    Process *process, lldb::LanguageType language);
typedef lldb::CommandObjectSP (*LanguageRuntimeGetCommandObject)(
    CommandInterpreter &interpreter);
typedef lldb::BreakpointPreconditionSP (
    *LanguageRuntimeGetExceptionPrecondition)(lldb::LanguageType language,
                                              bool throw_bp);
typedef lldb::StructuredDataPluginSP (*StructuredDataPluginCreateInstance)(
    Process &process);
typedef Status (*StructuredDataFilterLaunchInfo)(ProcessLaunchInfo &launch_info,
                                                 Target *target);
typedef SystemRuntime *(*SystemRuntimeCreateInstance)(Process *process);
typedef lldb::PlatformSP (*PlatformCreateInstance)(bool force,
                                                   const ArchSpec *arch);
typedef lldb::ProcessSP (*ProcessCreateInstance)(
    lldb::TargetSP target_sp, lldb::ListenerSP listener_sp,
    const FileSpec *crash_file_path);
typedef lldb::ScriptInterpreterSP (*ScriptInterpreterCreateInstance)(
    Debugger &debugger);
typedef SymbolFile *(*SymbolFileCreateInstance)(lldb::ObjectFileSP objfile_sp);
typedef SymbolVendor *(*SymbolVendorCreateInstance)(
    const lldb::ModuleSP &module_sp,
    lldb_private::Stream
        *feedback_strm); // Module can be NULL for default system symbol vendor
typedef bool (*BreakpointHitCallback)(void *baton,
                                      StoppointCallbackContext *context,
                                      lldb::user_id_t break_id,
                                      lldb::user_id_t break_loc_id);
typedef bool (*WatchpointHitCallback)(void *baton,
                                      StoppointCallbackContext *context,
                                      lldb::user_id_t watch_id);
typedef bool (*ThreadPlanShouldStopHereCallback)(
    ThreadPlan *current_plan, Flags &flags, lldb::FrameComparison operation,
    Status &status, void *baton);
typedef lldb::ThreadPlanSP (*ThreadPlanStepFromHereCallback)(
    ThreadPlan *current_plan, Flags &flags, lldb::FrameComparison operation,
    Status &status, void *baton);
typedef UnwindAssembly *(*UnwindAssemblyCreateInstance)(const ArchSpec &arch);
typedef lldb::MemoryHistorySP (*MemoryHistoryCreateInstance)(
    const lldb::ProcessSP &process_sp);
typedef lldb::InstrumentationRuntimeType (*InstrumentationRuntimeGetType)();
typedef lldb::InstrumentationRuntimeSP (*InstrumentationRuntimeCreateInstance)(
    const lldb::ProcessSP &process_sp);
typedef lldb::TypeSystemSP (*TypeSystemCreateInstance)(
    lldb::LanguageType language, Module *module, Target *target,
    const char *compiler_options);
typedef lldb::REPLSP (*REPLCreateInstance)(Status &error,
                                           lldb::LanguageType language,
                                           Debugger *debugger, Target *target,
                                           const char *repl_options);
typedef int (*ComparisonFunction)(const void *, const void *);
typedef void (*DebuggerInitializeCallback)(Debugger &debugger);

} // namespace lldb_private

#endif // #if defined(__cplusplus)

#endif // LLDB_LLDB_PRIVATE_INTERFACES_H
